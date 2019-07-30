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
				// X(q); // flip qubit
				H(q); // hadamard gate - statistically get 1 half of the time or 0, either or gives superposition
				let matrix = M(q); // set matrix as q

				if (matrix == One) { // One is the quantum representation of 1 (as a vector v = |1>)
					set numberOfOnes += 1;
				}
			}
			Set(Zero, q); // set Qubit to zero
		}

		// return (# |0>, # |1>)
		return (count-numberOfOnes, numberOfOnes);
	}

	// entangle two qubits
	operation Entanglement(count: Int, initial: Result): (Int, Int, Int) {
		mutable numberOfOnes = 0;
		mutable equal = 0;
		using ((q0, q1) = (Qubit(), Qubit())) { // using allocates Qubits in code
			for (item in 1..count) {
				// assign qbits
				Set (initial, q0);
                Set (Zero, q1);
				//hadamard gate to get either 0 or 1
                H(q0);
                CNOT(q0,q1);
				if (M(q1) == M(q0)) {
					set equal += 1;
				}
				if (M(q0) == One) { // One is the quantum representation of 1 (as a vector v = |1>)
					set numberOfOnes += 1;
				}
			}
			Set(Zero, q0); // set Qubit to zero
			Set(Zero, q1); // set Qubit to zero
		}

		// return (# |0>, # |1>)
		return (count-numberOfOnes, numberOfOnes, equal);
	}
}
