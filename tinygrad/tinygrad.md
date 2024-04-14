# Tinygrad learnings


## Reasons to learn

Intrigued about all you need is 20(21) ops in the accelerator. Would like to make an accelerator in fpga, enable it to run neural nets?

## Investigating, research, where to begin.

Issues running in windows. seem I get gpu acceleration but other parts does not work, so had to enable WSL and run there. Now the function failing in windows works (save model) but it does not seem to use the GPU for acceleration.

I had the hypervisorlaunchtype set to off, can check if its set with bcdedit and delete if its set. (I had it set to run som old virtual box)
 ```bcdedit /deletevalue hypervisorlaunchtype```


 Can I get GPU working in windows using WSL? How?
 