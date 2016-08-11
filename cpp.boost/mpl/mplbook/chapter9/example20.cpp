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

        cl /nologo /Zm800 /EHsc -I- -I..\..\boost_1_32_0  /Fe%TEMP%\metaprogram-chapter9-example20.exe example20.cpp

*/
#include <boost/mpl/vector.hpp>
#include <boost/type_traits/is_same.hpp>
#include <algorithm>

#include <boost/mpl/placeholders.hpp>
#include <boost/mpl/assert.hpp>
#include <boost/static_assert.hpp>
namespace mpl = boost::mpl;
using namespace mpl::placeholders;

#include <iostream>
#include <typeinfo>
typedef mpl::vector<int&, long&, char*&> s;
#include <functional>

    template <class T, class U>
    int test_type_of(U const&)
    {
        BOOST_MPL_ASSERT((boost::is_same<T,U>));
        return 0;
    }

#include <cmath>
using namespace std; // in MSVC6, sin is not in std.
float sin_squared(float x) { return sin(sin(x)); }
#undef log2 // g++'s <cmath> seems to define this symbol
#include <functional>

template <class R, class F, class G>
class compose_fg
{
 public:
    compose_fg(F const& f, G const& g)
      : f(f), g(g)
    {}

    template <class T>
    R operator()(T const& x) const
    {
        return f(g(x));
    }

 private:
    F f;
    G g; 
};


template <class R, class F, class G>
compose_fg<R,F,G> compose(F const& f, G const& g)
{
    return compose_fg<R,F,G>(f,g);
}



    float input[5] = {0.0, 0.1, 0.2, 0.3, 0.4};
    float output[5];
    int main() {

std::transform(
    input, input+5, output
  , compose<float>(std::negate<float>(), &sin_squared)
);

std::transform(
    input, input+5, output
  , std::bind2nd(std::multiplies<float>(), 3.14159)
);

return 0;
}

