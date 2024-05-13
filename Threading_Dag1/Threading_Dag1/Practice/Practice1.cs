using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Threading_Dag1.Practice
{
    internal class Practice1
    {
        internal void ThreadFunction()
        {
            for (int i = 0; i < 5; i++)
            {
                Console.WriteLine("C#-trådning er nemt!");
            }
        }

        internal void Main()
        {
            Thread thread = new Thread(ThreadFunction);
            thread.Start();
            Console.ReadLine();
        }
    }
}
