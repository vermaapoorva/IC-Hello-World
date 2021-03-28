class Goal {
  String goalid;
  String goalName;
  String groupId;
  String description;
  String frequency;

  Goal(String goalid, String goalName, String groupId, String description, String frequency) {
    this.goalid = goalid;
    this.goalName = goalName;
    this.groupId = groupId;
    this.description = description;
    this.frequency = frequency;
  }

  String getGoalId() {
    return goalid;
  }

  String getGoalName() {
    return goalName;
  }

  String getGroupId() {
    return groupId;
  }

  String getDescription() {
    return description;
  }

  String getFrequency() {
    return frequency;
  }
}