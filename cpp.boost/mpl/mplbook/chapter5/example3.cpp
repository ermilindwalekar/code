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

        cl /nologo /Zm800 /EHsc -I- -I..\..\boost_1_32_0 -c /Fo%TEMP%\metaprogram-chapter5-example3.o example3.cpp

*/
#include <boost/mpl/vector.hpp>
#include <boost/mpl/find.hpp>
#include <boost/mpl/begin_end.hpp>
#include <boost/type_traits/is_same.hpp>

#include <boost/mpl/placeholders.hpp>
#include <boost/mpl/assert.hpp>
#include <boost/static_assert.hpp>
namespace mpl = boost::mpl;
using namespace mpl::placeholders;


typedef mpl::vector<char,short,int,long,float,double> types;

// locate the position of long in types
typedef mpl::find<types,long>::type long_pos;


// assert that long was found in the sequence.
typedef mpl::end<types>::type finish;
BOOST_STATIC_ASSERT((!boost::is_same<long_pos, finish>::value));
