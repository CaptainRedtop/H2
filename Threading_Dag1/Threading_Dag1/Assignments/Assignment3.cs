using System;
using System.Threading;

namespace Threading_Dag1.Tasks
{
    internal class Assignment3
    {
        bool threadRunning = true;
        Random rand = new Random();
        int temp;
        byte alarmCount = 0;

        internal void ThreadFunction()
        {
            while (threadRunning)
            {
                temp = rand.Next(-20, 121);
                Console.WriteLine(temp);

                if (temp < 0)
                {
                    Console.WriteLine("Alarm!! Temperature is too low!");
                    alarmCount++;
                }
                else if (temp > 100)
                {
                    Console.WriteLine("Alarm!! Temperature is too high!");
                    alarmCount++;
                }

                if (alarmCount == 3)
                {
                    threadRunning = false;
                }
                Thread.Sleep(2000);
                Console.Clear();
            }
        }

        internal void Main()
        {
            Thread thread = new Thread(ThreadFunction);
            thread.Start();

            // Timer to check if the thread is alive every 10 seconds
            Timer timer = new Timer(CheckThreadStatus, thread, TimeSpan.Zero, TimeSpan.FromSeconds(10));

            Console.ReadKey();

            // Clean up
            timer.Dispose();
            thread.Abort(); // Abort the thread
        }

        static void CheckThreadStatus(object state)
        {
            Thread thread = (Thread)state;
            if (!thread.IsAlive)
            {
                Console.WriteLine("Alarm-thread terminated.");
            }
        }
    }
}
