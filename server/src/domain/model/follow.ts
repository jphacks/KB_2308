export type FollowStatus = "requesting" | "pending" | "friend";

type TFollow = {
  userID: string;
  targetUserID: string;
  status: FollowStatus;
  createdAt: Date;
  updatedAt: Date;
};

interface IFollow {}

export class Follow implements TFollow, IFollow {
  userID: string;
  targetUserID: string;
  status: FollowStatus;
  createdAt: Date;
  updatedAt: Date;

  constructor(
    userID: string = "",
    targetUserID: string = "",
    status: FollowStatus = "requesting",
    createdAt: Date = new Date(),
    updatedAt: Date = new Date()
  ) {
    this.userID = userID;
    this.targetUserID = targetUserID;
    this.status = status;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }
}
