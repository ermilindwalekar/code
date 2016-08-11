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

        cl /nologo /Zm800 /EHsc -I- -I..\..\boost_1_32_0 -c /Fo%TEMP%\metaprogram-appendixB-example26.o example26.cpp

*/

#include <boost/mpl/placeholders.hpp>
#include <boost/mpl/assert.hpp>
#include <boost/static_assert.hpp>
namespace mpl = boost::mpl;
using namespace mpl::placeholders;

template <class T> struct whatever;

template <class T> void f(T& x, T* y)
{
    int n = x.template convert<int>();
    int m = y->template convert<int>();
}

template <class T> 
struct other
{
    template <class U> struct base {};
};

template <class T> 
struct derived
  : other<T>::template base<int>
{};

template <class T> 
struct derived1
  : other<int>::base<T>               // OK
{};

template <class T> 
struct derived2
  : other<int>::template base<T>     // also OK
{};
