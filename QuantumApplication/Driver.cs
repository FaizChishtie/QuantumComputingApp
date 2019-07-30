using System;
using System.Runtime.InteropServices;
using Microsoft.Quantum.Intrinsic;
using Microsoft.Quantum.Canon;
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
                TestBell(qsim);
                TestEntanglement(qsim);
            }

            System.Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }

        public void TestBell(QuantumSimulator qsim)
        {
            Start("Bell");
            Result[] init = new Result[] { Result.Zero, Result.One };
            foreach (Result vector in init)
            {
                var res = Bell.Run(qsim, 1000, vector).Result;
                var (zeros, ones) = res;
                System.Console.WriteLine($"Init:{vector,-4} 0s={zeros,-4} 1s={ones,-4}");
            }
            End("Bell");
        }

        public void TestEntanglement(QuantumSimulator qsim)
        {
            Start("Entanglement");
            System.Console.WriteLine($"Testing Entanglement operation");
            Result[] init = new Result[] { Result.Zero, Result.One };
            foreach (Result vector in init)
            {
                var res = Entanglement.Run(qsim, 1000, vector).Result;
                var(zeros, ones, equal) = res;
                System.Console.WriteLine(
                    $"Init:{vector,-4} 0s={zeros,-4} 1s={ones,-4} agree={equal,-4}");
            }
            End("Entanglement");
        }

        private void Start(String op)
        {
            System.Console.WriteLine($"------------------ Testing {op} operation ------------------\n");
        }

        private void End(String op)
        {
            System.Console.WriteLine($"\n---------------- End of {op} operation test ----------------\n");
        }
    }
}