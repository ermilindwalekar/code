#ifndef NANDIMAGE_H
#define NANDIMAGE_H

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
namespace utility { namespace hex {
    class ByteBuffer;        
}
}

class NANDImage
{
public:
    virtual ~NANDImage()
    {
    }

public:
    auto virtual read_page() -> utility::hex::ByteBuffer = 0;
};

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
#endif
