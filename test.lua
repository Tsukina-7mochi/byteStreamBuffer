-- load library
dofile("./byteStreamBuffer.lua")


-- append byte numbers
-- index access to buffer
local bsb1 = byteStreamBuffer()
bsb1:append(0x00, 0x7F, 0xFF);
bsb1[1] = 0x20

print(bsb1)
-- output: byteStreamBuffer[3] { 32, 127, 255 }


-- append numbers of specific size with little endian and big endian
local bsb2 = byteStreamBuffer()
bsb2:appendMultiByteLE(1, 4)
bsb2:appendMultiByteLE(2, 4)

print(bsb2)
-- output: byteStreamBuffer[8] { 1, 0, 0, 0, 2, 0, 0, 0 }


local bsb3 = byteStreamBuffer()
bsb3:appendMultiByteBE(1, 4)
bsb3:appendMultiByteBE(2, 4)

print(bsb3)
-- output: byteStreamBuffer[8] { 0, 0, 0, 1, 0, 0, 0, 2 }


-- apply pack bits to the buffer
local bsb4 = byteStreamBuffer()
bsb4:append(0, 0, 0, 0, 1, 1, 2, 3, 4, 5, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1)

print(bsb4:packBits())
-- output: byteStreamBuffer[14] { 253, 0, 255, 1, 3, 2, 3, 4, 5, 0, 250, 0, 254, 1 }


-- get slice of buffer and append to buffer
local bsb5 = byteStreamBuffer()
bsb5:append(bsb4:slice(5, -5))
bsb5:append(0xFF, 0xFF, 0xFF)

print(bsb5)
-- output: byteStreamBuffer[14] { 1, 1, 2, 3, 4, 5, 0, 0, 0, 0, 0, 255, 255, 255 }


-- append string to buffer
local bsb6 = byteStreamBuffer()
bsb6:append("string")

print(bsb6)
-- output: byteStreamBuffer[6] { 115, 116, 114, 105, 110, 103 }


-- append string to buffer as pascal string
local bsb7 = byteStreamBuffer()
bsb7:appendPascalString("new string")

print(bsb7)
-- output: byteStreamBuffer[11] { 10, 110, 101, 119, 32, 115, 116, 114, 105, 110, 103 }
print(bsb7:tostring())
-- output: [LF] new string


-- concat buffers
local bsb8 = bsb1 .. bsb2 .. bsb6

print(bsb8)
-- output: byteStreamBuffer[17] { 32, 127, 255, 1, 0, 0, 0, 2, 0, 0, 0, 115, 116, 114, 105, 110, 103 }

