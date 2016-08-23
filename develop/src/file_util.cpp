#include <fstream>

using namespace std;
////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
auto file_size(const char* filename) -> ifstream::pos_type
{
  ifstream ifs(filename, ios::ate | ios::binary);

  return ifs.tellg();
}

auto file_size(istream& ifs) -> ifstream::pos_type
{
  if (!ifs.good())
    return 0;

  auto backup_pos = ifs.tellg();
  ifs.seekg(0, ios::end);
  auto result = ifs.tellg();

  ifs.seekg(backup_pos, ios::beg);

  return result;
}

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
