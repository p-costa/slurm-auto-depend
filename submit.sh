#!/bin/bash
echo "SLURM script filename?"
read jobscript
echo "job ID (0 if the first job has no dependencies)?"
read jobid
echo "number of jobs to submit?"
read njobs
echo "dependency type (e.g. afterany; afterok)?"
read depend
echo "other command-line options (e.g. -N <number-of-nodes>, or leave empty line)?"
read opts
m=njobs
if [ $jobid -eq 0 ]
then
  m=$(($m-1))
  jobid=$(sbatch $opts $jobscript | tr -dc '0-9')
fi
for (( i=1; i<=$m; i++ ))
do
  jobid=$(sbatch $opts --dependency=$depend:$jobid $jobscript | tr -dc '0-9')
done
