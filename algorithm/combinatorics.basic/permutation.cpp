#include <iostream>
#include <string>

using namespace std;

void string_permutation(string head, string tail)
{
  if (head.empty())
    cout << tail << endl;

  for (int i=0; i<head.size(); ++i)
    string_permutation(head.substr(0, i) + head.substr(i+1), 
        tail + head[i]);
}

int main(int argc, const char *argv[])
{
  string head = "12345";
  string tail = "";

  string_permutation(head, tail);
  
  return 0;
}
