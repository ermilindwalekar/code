#import <Foundation/Foundation.h>

int main(int argc, char const* argv[])
{
<<<<<<< HEAD
  NSAutoreleasePool *po = [[NSAutoreleasePool alloc] init];
  NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];

  NSLog(@"leech");
  NSLog(@"%s", [dict description]);

  [po drain];
  
=======
  int i;
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  NSMutableArray *array = [[NSMutableArray alloc] init];

  for (i=0; i<10; i++)
  {
    NSNumber *newNumber = [[NSNumber alloc] initWithInt:(i * 3)];
    [array addObject:newNumber];
  }

  for (i=0; i<10; i++)
  {
    NSNumber *numberToPrint = [array objectAtIndex:i];
    NSLog(@"The number at index %d is %@", i, numberToPrint);
  }

  [pool drain];
>>>>>>> 9f9f7772d76b4192ce77d5b35929227da092e293
  return 0;
}
