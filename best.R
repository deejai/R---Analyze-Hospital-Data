## David Ferguson 7/17/15

## Get the best hospital in a given state in terms of lowest mortality rate by
## the given cause of death

best <- function(state, outcome) {

	## Read outcome data (type: "heart attack", "heart failure", or "pneumonia")
		outcome_data <- read.csv("data/outcome-of-care-measures.csv",
									colClasses = "character")

	## Validate state and outcome, designate outcome column, filter data by state

		## Column 11: 30-Day Heart Attack Mortality
		## Column 17: 30-Day Heart Failure Mortality
		## Column 23: 30-Day Pneumonia Mortality
		     if( outcome == "heart attack"  )	outcome_col <- 11
		else if( outcome == "heart failure" )	outcome_col <- 17
		else if( outcome == "pneumonia"     )	outcome_col <- 23
		else stop("invalid outcome")

		if( !is.character(state) || 
				nrow( outcome_data[ outcome_data$State == state, ] ) <= 1 ){
			stop("invalid state")
		}

		## Convert outcome column to numeric values
  		suppressWarnings(
  			outcome_data[,outcome_col] <- as.numeric( outcome_data[,outcome_col] )
  		) ## Ignore warning about NAs

		## Filter data by state
			outcome_data <- outcome_data[ outcome_data$State == state, ]

	## Return hospital name in that state with lowest 30-day death rate
		lowestMortalityRate <- min( outcome_data[,outcome_col], na.rm = TRUE )
		hasLowestMortality <- outcome_data[,outcome_col] == lowestMortalityRate
		lowestMortalityHospitals <- outcome_data[ which( hasLowestMortality ),
														"Hospital.Name" ]
		lowestMortalityHospitals <- sort( lowestMortalityHospitals )

		return( lowestMortalityHospitals[1] )

}