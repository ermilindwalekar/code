#ifndef FILE_SYSTEM_EXT_H
#define FILE_SYSTEM_EXT_H

#include <mruby.h>
////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
class FileSystem;

auto fs_wrap(mrb_state* mrb, FileSystem* fs) -> mrb_value;
auto init_file_system(mrb_state* mrb) -> void;

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
#endif
