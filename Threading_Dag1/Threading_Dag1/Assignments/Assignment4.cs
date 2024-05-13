using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Threading_Dag1.Tasks
{
    internal class Assignment4
    {
        char ch = '*';
        internal void ThreadPrinter()
        {
            while (true)
            {
                Console.Write(ch);
                Thread.Sleep(20);
            }
        }
        internal void ThreadReader()
        {
            while(true)
            {
                ch = Console.ReadKey().KeyChar;
            }

        }
        internal void Main()
        {
            Thread printer = new Thread (ThreadPrinter);
            Thread reader = new Thread (ThreadReader);

            printer.Start ();
            reader.Start ();


        }
    }
}
