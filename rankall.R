## David Ferguson 7/17/2015

## Output the hostpital for each state ranked "num" lowest in mortality for the
## given cause of death in its respective state

rankall <- function(outcome, num = "best") {

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

		## Convert outcome column to numeric values
  		suppressWarnings(
  			outcome_data[,outcome_col] <- as.numeric( outcome_data[,outcome_col] )
  		) ## Ignore warning about NAs

		## Remove rows with NA mortality rate
			outcome_data <- outcome_data[ !is.na(outcome_data[,outcome_col]), ]

	  ## Validate num
  		if( !is.numeric(num) ){
  				 if( num == "best" ) 	numFun <- function(x) return ( 1 )
  			else if( num == "worst" )	numFun <- function(x) return ( nrow(x) )
  			else( stop("invalid num") )
  		}
  		else if( num < 1 )	stop("invalid num")
  		else numFun <- function(x) return( num )
  
  		state_list <- sort( unique( outcome_data$State ) )

		## Initialize matrix to store nth ranked hospitals
  		data_list <- matrix( nrow= length(state_list), ncol=2 )
  		colnames( data_list ) <- c("hospital", "state")
  		rownames( data_list ) <- state_list
  		data_list[,2] <- state_list

		## For each state, add the nth ranked hospital to the matrix
  		index <- 1
  		for( var_state in state_list ){
  			state_data <- outcome_data[outcome_data$State==var_state,]
  			state_data <- state_data[ order( state_data[,outcome_col],
  								state_data$Hospital.Name ), ]
  			if( numFun( state_data ) > nrow( state_data ) ){
  				data_list[index,1] <- NA
  			}
  			else{
  				data_list[index,1] <- state_data[ numFun( state_data ), "Hospital.Name"]
  			}
  			index <- index + 1
  		}

		## Convert matrix to data frame and return it
  		states_df <- data.frame( data_list )
  		return( states_df )

}
