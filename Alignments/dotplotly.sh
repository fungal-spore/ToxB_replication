#check dotplotly github for the R script
#mamba activate R
#check R script and make sure you have necessary repos installed
./pafCoordsDotPlotly.R -i $1 -o out -s -t -m 25 -q 25 -l
mv out.png $1.png
