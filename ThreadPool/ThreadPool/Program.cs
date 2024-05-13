using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ThreadPool
{
    internal class ThreadPoolDemo
    {
        static void Main(string[] args)
        {
            Torturial torturial = new Torturial();

            ThreadPoolDemo tpd = new ThreadPoolDemo();

            System.Threading.ThreadPool.QueueUserWorkItem(tpd.task1);
            System.Threading.ThreadPool.QueueUserWorkItem(tpd.task2);

            //System.Threading.ThreadPool.QueueUserWorkItem(new WaitCallback(tpd.task1));
            //System.Threading.ThreadPool.QueueUserWorkItem(new WaitCallback(tpd.task2));


            Console.Read();
            Console.Clear();
            torturial.Main();
            Console.ReadLine();
        }
        public void task1(object obj)
        {
            for (int i = 0; i <= 2; i++)
            {
                Console.WriteLine("Task 1 is being executed");
            }
        }

        public void task2(object obj)
        {
            for (int i = 0; i <= 2; i++)
            {
                Console.WriteLine("Task 2 is being executed");
            }
        }
    }
}
