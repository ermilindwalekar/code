/*

    Copyright David Abrahams 2003-2004
    Copyright Aleksey Gurtovoy 2003-2004

    Distributed under the Boost Software License, Version 1.0. 
    (See accompanying file LICENSE_1_0.txt or copy at 
    http://www.boost.org/LICENSE_1_0.txt)
            
    This file was automatically extracted from the source of 
    "C++ Template Metaprogramming", by David Abrahams and 
    Aleksey Gurtovoy.

    It was built successfully with Microsoft Visual C++ 6.0 SP6
    using the following command: 

        cl /nologo /Zm800 /EHsc -I- -I..\..\boost_1_32_0 -c /Fo%TEMP%\metaprogram-chapter5-example97.o example97.cpp

*/
#include <boost/mpl/vector.hpp>

#include <boost/mpl/placeholders.hpp>
#include <boost/mpl/assert.hpp>
#include <boost/static_assert.hpp>
namespace mpl = boost::mpl;
using namespace mpl::placeholders;


#include <boost/mpl/vector/vector30.hpp> // 28 rounded up

// declare a sequence of 28 elements
typedef boost::mpl::vector28<
     char, int, int[1], int[2], int[3], int[4], int[5], int[6], int[7], int[8], int[9], int[10], int[11], int[12], int[13], int[14], int[15], int[16], int[17], int[18], int[19], int[20], int[21], int[22], int[23], int[24], int[25], int[26] /* ... 25 more types */
> s;
