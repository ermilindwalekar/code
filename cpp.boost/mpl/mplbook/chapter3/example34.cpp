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

        cl /nologo /Zm800 /EHsc -I- -I..\..\boost_1_32_0 -c /Fo%TEMP%\metaprogram-chapter3-example34.o example34.cpp

*/

    #include <boost/mpl/int.hpp>
    #include <boost/mpl/vector.hpp>


namespace boost{namespace mpl {}}
namespace mpl = boost::mpl;

#include <boost/static_assert.hpp>
#include <boost/mpl/transform.hpp>
#include <boost/mpl/minus.hpp>

#include<boost/mpl/placeholders.hpp>
using namespace mpl::placeholders;

#include <boost/type_traits/add_pointer.hpp>
    #include <boost/static_assert.hpp>
    #include <boost/type_traits/is_same.hpp>
#include <boost/mpl/lambda.hpp>
#include <boost/mpl/apply.hpp>
#include <boost/mpl/plus.hpp>
#include <boost/mpl/multiplies.hpp>

struct always_int
{
    typedef int type;
};



   #include <boost/mpl/vector.hpp>
   #include <boost/mpl/transform.hpp>

typedef mpl::vector<int, char*, double&> seq;
typedef mpl::transform<seq, boost::add_pointer<_> > calc_ptr_seq;
