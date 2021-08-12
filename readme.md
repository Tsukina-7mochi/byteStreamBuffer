# Byte Stream Buffer Library for Lua

## Abstract

This is a binary stream manipulation tool for Lua. This library adds a data structure `byteStreamBuffer`. `byteStreamBuffer` is the similar thing to `uint8_t` array but has more functions over that.

## Installation

Currently there is no support for `LuaRocks` or `LuaDist`. You can use `dofile` method or directory put into your source code.

```lua
dofile("./byteStreamBuffer.lua")
```

## Usage

See details in [test.lua](./test.lua)

### Create Buffer

You can create `byteStreamBuffer` instance by calling `byteStreamBuffer`.

```lua
local bsb = byteStreamBuffer()
```

### Append Items to Buffer

You can append items to `byteStreamBuffer`. You can append byte number (integer in range 0x00 to 0xFF), string, and other `byteStreamBuffer`. The `append` method can take multiple values to append in order. You can also mix multiple type of items. You can also specify endian, or append pascal string (see API section).

```lua
-- append one item
bsb:append(0x00)

-- append multiple item at the same time
bsb:append(0x00, 0xFF)

-- append string
bsb:append("string")

-- append other byteStreamBuffer
bsb:append(otherBsb)
```

### Access to Buffer

You  can directly access to buffer item like array. Also you can get string of byte code that the buffer represents.

```lua
-- directory access to buffer
bsb[1] = 0x00

-- use ipairs to iterate buffer items
for _, byte in ipairs(bsb) do
    -- something to do
end

-- get string
local str = bsb.tostring()
```

### Convert Buffer

There are some method to alter buffer into another buffer.

```lua
-- get slice of buffer
bsb:slice(1, 0)

-- compress with RLE
bsb:packBits()
```

## API

Every methods takes `byteStreamBuffer` to manipulate.

### append

```lua
append(bsb, ...)
```

Append items to `byteStreamBuffer`. Items from 2nd argument are append in order.

The syntax sugar of `appendByte`, `appendString`, `appendStreamBuffer`.

### appendByte

```lua
appendByte(bsb, data)
```

Append byte number (integer in range 0x00  to 0xFF) to `byteStreamBuffer`. 

### appendMultiByteLE

```lua
appendMultiByteLE(bsb, data, size)
```

Append integer to `byteStreamBuffer` in little endian. For example, append `0x00000001` in size of `4`, the byte sequence`{ 0x01, 0x00, 0x00, 0x00 }` will be appended.

### appendMultiByteBE

```lua
appendMultiByteBE(bsb, data, size)
```

Append integer to `byteStreamBuffer` in big endian. For example, append `0x00000001` in size of `4`, the byte sequence `{ 0x00, 0x00, 0x00, 0x01 }` will be appended.

### appendString

```lua
appendString(bsb, data)
```

Append string to `byteStreamBuffer` as byte sequence.

### appendPascalString

```
appendPascalString(bsb, data)
```

Append string to `byteStrenBuffer` as byte sequence. The length of string is appended ahead of string byte sequence.

### appendbyteStreamBuffer

```lua
appendbyteStreamBuffer(bsb, bsb2)
```

Append `byteStreamBuffer` to other `byteStreamBuffer`.

### clear

```
clear(bsb)
```

Clear buffer.

### tostring

```
tostring(bsb)
```

Convert `byteStreamBuffer` to string of byte code that the buffer represents. You can use `file:write` (binary mode) to write binary file.

### slice

```lua
slice(bsb, startIndex, lastIndex)
```

Get slice of `byteStreamBuffer`. The index starts with 1. If the index is less than 1, the index is regarded as `#bsb + index`. The item of `lastIndex` is included, so you can specify whole buffer as `slice(bsb, 1, 0)`.

### packBits

```lua
packBits(bsb)
```

Compress buffer with RLE (pack bits). This method always returns a new buffer.

## License

[MIT](./LICENSE)

