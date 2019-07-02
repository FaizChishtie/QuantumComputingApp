namespace Quantum.QuantumApplication
{
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    
    operation HelloQ () : Unit {
        Message("Hello quantum world!");
    }

	// should be more modular --> improve as needed

	// Sets a Qubit to state Zero or One
	// q1 is not observed before
	// Unit is void
	operation Set (desired: Result, q1: Qubit) : Unit {
		if (desired != M(q1)) {
			X(q1); // M and X are operations on a Qubit
		}
	}

	// measure a qubit
	operation Bell(count: Int, initial: Result): (Int, Int) {
		mutable numberOfOnes = 0; 
		using (q = Qubit()) { // using allocates Qubits in code
			for (item in 1..count) {
				Set(initial, q); // set temporary qubit to initial
				let matrix = M(q); // set matrix as q

				if (matrix == One) { // One is the quantum representation of 1 (as a vector v = |1>)
					set numberOfOnes += 1;
				}
			}
		}
		// (# |)
		return (count-numberOfOnes, numberOfOnes);
	}
}
