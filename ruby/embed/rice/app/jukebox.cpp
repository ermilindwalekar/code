#include "stdafx.h"
#include "jukebox.h"

#include <iostream>

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
CDJukebox::CDJukebox(int unit)
{
  std::cout << "CDJukebox ctor\n";
  m_unit_id = unit;
}

CDJukebox::CDJukebox(CDJukebox const& rhs)
{
  if (this != &rhs)
  {
    std::cout << "copy constructor is called\n";

    m_unit_id = rhs.m_unit_id;
  }
}

CDJukebox::~CDJukebox()
{
  std::cout << "CDJukebox dtor\n";
}

void CDJukebox::assign(int unit_id)
{
  m_unit_id = unit_id;
}

void CDJukebox::seek(int disc, int track)
{
  std::cout << "disc: " << disc << " track: " << track << std::endl;
}

int CDJukebox::unit()
{
  return m_unit_id;
}

int CDJukebox::set_unit(int unit)
{
  return m_unit_id = unit;
}

double CDJukebox::avg_seek_time()
{
  return 1.23;
}

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////
