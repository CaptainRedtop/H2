using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Threading_Dag1.Practice
{
    internal class Practice2
    {
        internal void ThreadFunction1()
        {
            for (int i = 0; i < 5; i++)
            {
                Console.WriteLine("C#-trådning er nemt!");
            }
        }

        internal void ThreadFunction2()
        {
            for (int i = 0; i < 5; i++)
            {
                Console.WriteLine("Også med flere tråde...");
            }
        }

        internal void Main()
        {
            Thread thread = new Thread(ThreadFunction1);
            Thread thread1 = new Thread(ThreadFunction2);
            thread.Start();
            Thread.Sleep(1000);
            thread1.Start();
            Console.ReadLine();
        }
    }
}
