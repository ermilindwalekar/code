#ifndef FILE_SYSTEM_H
#define FILE_SYSTEM_H

#include <stdint.h>
#include <string>
#include <vector>
////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
class FileBase
{
public:
  FileBase(char const* name="");

  auto length() -> int64_t;

private:  
  int64_t _length;
  std::string _name;
};

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
class FileSystem
{
public:
  FileSystem(char const* name="");
  FileSystem(FileSystem const& rhs);
  ~FileSystem();

public:
  auto name() -> std::string; 
  auto desc() -> std::string;
  auto add_file(FileBase* f) -> uint32_t;

private:
  std::string _name;
  std::vector<FileBase*> _files;
};

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
#endif
