# Technical Resource Allocation in Unity: Optimizing Frame Rates and Player Experience

### Details of variables used
Name | Variable | Type | Value
---  | ---      | ---  | ---
Levels | LEVEL | Interger | [1,5]
Actual Audio | AA | Categorical (Ordinal) | [1,3]
Actual Graphics | AG | Categorical (Ordinal) | [1,3]
Actual Physics | AP | Categorical (Ordinal) | [1,3]
Audio Rating | AR | Interger | [1,5]
Graphics Rating | GR | Interger | [1,5]
Physics Rating | PR | Interger | [1,5]
Enjoyment Rating | ER | Interger | [1,5]
Comfort Rating | CR | Interger | [1,5]
Overall Satisfaction Rating | OR | Interger | [1,5]
Score | SCORE | Interger | [0,1000]
Average FPS| AVGFPS | Interger | [30,60]
Gaming Interest and Experience Rating | GAMING | Interger | [1,5]
Participant Number | PCP | Interger | [1,25]
Player Experience (avg of all _R) | PE | Continuous (Decimal) | [1,5]
Normalized data of AA, AG, AP, AVGFPS, PE | NAA, NAG, NAP, NAVGFPS, NPE | Continuous (Decimal) | [0,1]
Normalized data of 0.5AVGFPS+0.5PE | NFPSPE | Continuous (Decimal) | [0,1]

### Main Research Questions
1. Which of the technical variables (`AA`/`AG`/`AP`) have the most influence on AVGFPS?
2. Which of the technical variables (`AA`/`AG`/`AP`) have the most influence on PE?
3. What is the optimal combination of the technical variables (`AA`/`AG`/`AP`) to achieve optimal `NFPSPE`?

### Side Research Questions
4. Which technical variables (`AA`/`AG`/`AP`) settings do most participants prefer?
5. Does the Score (`SCORE`) depend on Comfort (`CR`)?
6. Does the Gaming Interest and Experience Rating (`GAMING`) truly reflect on the variability in all the rating variables (`AR`, `GR`, `PR`, `ER`, `CR`, `OR`)?  


#
#### Notes
- `dec_tree.R` and `dec_tree_N.R` files are created for answering question 1
