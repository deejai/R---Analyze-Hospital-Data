# Hospital Ranker
Written in R by David Ferguson

### best( state, outcome )
Output the name of the hospital with the lowest 30-day mortality rate in for ```outcome``` in ```state```.
* **state** <- [String] The two-letter abbreviation of a state (US)
    * Restraints: ```state = "AL", "AK", ... , "WY"```
* **outcome** <- [String] A cause of death
    * Restraints: ```outcome = "heart attack" , "heart failure" , "pneumonia"```
* **return value** -> [String] The name of a hospital
    * Example:
    * ```
            > best( "OH, "heart failure")
            [1] "FAIRVIEW HOSPITAL"
### rankhospital( state, outcome, num )
Output the name of the hospital ranked ```num``` lowest in 30-day mortality rate for ```outcome``` in ```state```.
* **state** <- [String] The two-letter abbreviation of a state (US)
    * Restraints: ```state = "AL", "AK", ... , "WY"```
* **outcome** <- [String] A cause of death
    * Restraints: ```outcome = "heart attack" , "heart failure" , "pneumonia"```
* **num** <- [Integer OR String] A state ranking
    * Integer restraints: ```num > 0```
    * Non-integer restraints: ```num = "best" , "worst"```
    * Default: ```num = "best"```
* **return value** -> [String] The name of a hospital
    * Example:
    * ```
            > rankhospital( "FL, "pneumonia", 3)
            [1] "DELRAY MEDICAL CENTER"
### rankall( outcome, num )
For each state, output the name of the hospital ranked ```num``` lowest in 30-day mortality rate for ```outcome```.
* **outcome** <- [String] A cause of death
    * Restraints: ```outcome = "heart attack" , "heart failure" , "pneumonia"```
* **num** <- [Integer OR String] A state ranking
    * Integer restraints: ```num > 0```
    * Non-integer restraints: ```num = "best" , "worst"```
    * Default: ```num = "best"```
* **return value** -> [Data Frame] A list of hospital names with the associated states
    * Example:
    * ```
            > head(rankall("heart attack", "worst"))
                                       hospital state
            AK   MAT-SU REGIONAL MEDICAL CENTER    AK
            AL   HELEN KELLER MEMORIAL HOSPITAL    AL
            AR    MEDICAL CENTER SOUTH ARKANSAS    AR
            AZ      VERDE VALLEY MEDICAL CENTER    AZ
            CA METHODIST HOSPITAL OF SACRAMENTO    CA
            CO    NORTH SUBURBAN MEDICAL CENTER    CO