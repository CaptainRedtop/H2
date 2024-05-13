using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Threading_Dag1.Practice;
using Threading_Dag1.Tasks;

namespace Threading_Dag1
{
    
    internal class Program
    {
        static void Main(string[] args)
        {
            //Choose which task to run by outcommenting all another.
            Practice0 practice0 = new Practice0();
            Practice1 practice1 = new Practice1();
            Practice2 practice2 = new Practice2();
            Assignment3 assignment3 = new Assignment3();
            Assignment4 assignment4 = new Assignment4();

            //practice0.Main();
            //practice1.Main();
            //practice2.Main();
            //assignment3.Main();
            assignment4.Main();
        }
    }
}
