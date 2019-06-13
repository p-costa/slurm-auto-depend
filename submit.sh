echo "what is the name of the jobscript"
read jobscript
echo "what is the job ID (0 if the first job has no dependencies)"
read jobid
echo "how many jobs do you want to submit?"
read njobs
echo "what is the type of dependency (e.g. afterany; afterok)"
read depend
m=njobs
if [ $jobid -eq 0 ]
then
  m=$(($m-1))
  jobid=$(sbatch $jobscript | tr -dc '0-9')
fi
for (( i=1; i<=$m; i++ ))
do
  jobid=$(sbatch --dependency=$depend:$jobid $jobscript | tr -dc '0-9')
done
