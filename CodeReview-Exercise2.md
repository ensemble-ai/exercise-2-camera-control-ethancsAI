# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Duy Nguyen 
* *email:* dubnguyen@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Everything works perfectly as specif. Characters are always in the center of the screen.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Everything works as specify, box move in the x-z axis, and player are pushed by the box correctly.

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera follow behind the player, the player even when the player boost.

___
### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Every work correctly, camera go ahead of player and pause before coming back to player when they stop.

___
### Stage 5 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The most inner box does not move the camera, which is correct, the most outer box can be pushed by the player which is also correct. But the area between the two boxes is implemented incorrectly. If the player dont move in the middle box, they are pushed back to the inner box which is an incorrect implementation.
___
# Code Style #


### Description ###
#### Style Guide Infractions ####

#### Style Guide Exemplars ####

___
#### Put style guide infractures ####

___

# Best Practices #
#### Best Practices Infractions ####

* [In speed_up_push_camera.gd](https://github.com/ensemble-ai/exercise-2-camera-control-ethancsAI/blob/3c94d29e827bd72d5f0fed967281c1b783a129e2/Obscura/scripts/camera_controllers/speed_up_push_camera.gd#L6) here are a bit too many export variables than necessary. I think many came from the misinterpretation of the problem, but some varible could be calculated using the required export varible like[ box width and box height](https://github.com/ensemble-ai/exercise-2-camera-control-ethancsAI/blob/3c94d29e827bd72d5f0fed967281c1b783a129e2/Obscura/scripts/camera_controllers/speed_up_push_camera.gd#L8) can be calculated with pushbox_top_left and pushbox_bottom_right.

#### Best Practices Exemplars ####

Student does a great job of declaring variable types and auto type decleration. 