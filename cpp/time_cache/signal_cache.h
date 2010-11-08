#ifndef _SIGNAL_CACHE_H_
#define _SIGNAL_CACHE_H_

#include <algorithm>
#include <string>
#include <vector>
#include <ostream>

//#include <boost/shared_ptr.hpp>
#include <boost/format.hpp>

///////////////////////////////////////////////////////////////////////////////
//
//
//
///////////////////////////////////////////////////////////////////////////////                                  
struct RFSignal
{
  RFSignal()
    : m_rid(0), m_tid(0), m_rssi(0), m_value(0), m_status(0), m_time(0)
  {}

  RFSignal(int rid, int tid, int rssi, int value, int status, int time=0)
    : m_rid(rid), m_tid(tid), m_rssi(rssi), m_value(value)
    , m_status(status)
    , m_time(time)
  {}

  friend std::ostream& operator <<(std::ostream& os, RFSignal const& e)
  {
    os << e.m_time  << " "
       << e.m_tid   << " "
       << e.m_rid   << " " 
       << e.m_rssi  << " "
       << e.m_value << " "
       << e.m_status << "\n";
    
    return os;
  }

  bool operator<(RFSignal const& item) 
  {      
    return m_tid < item.m_tid;
  }

  std::string to_s()
  {
    return boost::str(boost::format("[%d, %d, %d, %d, %d, %d]")
                % m_rid % m_tid % m_rssi % m_value % m_status % m_time);
  }

  int m_rid;
  int m_tid;
  int m_rssi;
  int m_value;
  int m_status;
  int m_time;
};    

typedef std::vector<RFSignal> RFSignals;

///////////////////////////////////////////////////////////////////////////////
//
//
//
///////////////////////////////////////////////////////////////////////////////
class RFSignalCacheImpl;
namespace boost { template<typename T> class shared_ptr; }

class RFSignalCache
{
public:
  // REMARK: 우리 캐쉬는 항상 시간이 업데이트 되므로 hit == update
  enum { cache_new, cache_update, cache_hit, cache_discard };

public:
  RFSignalCache();
  ~RFSignalCache();

  int       cache_within_duration(int rid, int tid, int value, int rssi, int status, int duration);
  int       cache(int rid, int tid, int rssi, int value, int status);
  RFSignals get_signals_within(int seconds);
  RFSignals get_signals_in_reader(int rid);
  void      clear();
  size_t    count();

private:
  boost::shared_ptr<RFSignalCacheImpl> m_impl;
};

///////////////////////////////////////////////////////////////////////////////
//
//
//
///////////////////////////////////////////////////////////////////////////////
#endif
