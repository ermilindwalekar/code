#ifndef HTTP_SOURCE_H_KCO69NC1
#define HTTP_SOURCE_H_KCO69NC1

#include <boost/iostreams/concepts.hpp>
#include <memory>
#include <string>

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
class HTTPSource: public boost::iostreams::source
{
public:
  HTTPSource();
  HTTPSource(std::string const& url, int timeout=60);
 ~HTTPSource() = default;

  auto handshake();
  auto handshake(std::string const& url, int timeout=60);

public:
  auto read(char* s, std::streamsize n) -> std::streamsize;

  auto timeout(int to);
  auto timeout();

  auto url(std::string const& url);
  auto url();

private:
  struct Impl;
  std::shared_ptr<Impl> m_impl;
};

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
#endif
