baselines
baseline: spec
	<baseline>

	spec for: #common do: [
		spec package: 'Containers-PersistentQueue'.
		
		spec package: 'Containers-PersistentQueue-Tests' with: [
			spec requires: #('Containers-PersistentQueue')
		].
		
		spec package: 'Containers-PersistentQueue-Benchmarks' with: [
			spec requires: #('Containers-PersistentQueue')
		].

		spec group: 'Core' with: #('Containers-PersistentQueue').
		spec group: 'Tests' with: #('Containers-PersistentQueue-Tests').
		spec group: 'Benchmarks' with: #('Containers-PersistentQueue-Benchmarks').
		spec group: 'default' with: #('Core' 'Tests' 'Benchmarks').
	]