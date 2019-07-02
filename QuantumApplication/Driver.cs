using System;
using System.Runtime.InteropServices;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.QuantumApplication
{
    class Driver
    {
        static void Main(string[] args)
        {
            Driver qdriver = new Driver();
            qdriver.Test();
        }

        public void Test() 
        {
            using (var qsim = new QuantumSimulator())
            {
                TestHelloQ(qsim);
                TestBell(qsim);
            }

            System.Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }

        public void TestHelloQ(QuantumSimulator qsim)
        {
            HelloQ.Run(qsim).Wait();
        }

        public void TestBell(QuantumSimulator qsim)
        {
            Result init = new Result[] { Result.Zero, Result.One };
            foreach (Result vector in init)
            {
                var res = Bell.Run(qsim, 1000, initial).Result;
                var (zeros, ones) = res;
                System.Console.WriteLine($"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4}");
            }
        }
    }
}