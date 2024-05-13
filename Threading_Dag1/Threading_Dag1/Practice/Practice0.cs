using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Threading_Dag1.Practice
{
    internal class Practice0
    {
        //Method to be used by the thread
        internal void WorkThreadFunction()
        {
            // Write the current threadname
            Console.WriteLine($"Thread '{Thread.CurrentThread.Name}' executing WorkThreadFunction");

            //Loop 5 times and print "Simple Thread" to console.
            for (int i = 0; i < 5; i++)
            {
                Console.WriteLine("Simple Thread");
            }
        }
        internal void Main()
        {
            // Making the first thread
            Thread KingThread = new Thread(new ThreadStart(WorkThreadFunction));
            KingThread.Name = "KingThread";

            // Making the second thread
            Thread QueenThread = new Thread(new ThreadStart(WorkThreadFunction));
            QueenThread.Name = "QueenThread";

            // Start threads
            KingThread.Start();
            QueenThread.Start();

            //Waiting for user input before closing application
            Console.Read();
        }
    }
}
