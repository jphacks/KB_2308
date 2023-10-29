type TUserProfile = {
  id: string;
  userID: string;
  name: string;
  imageUrl: string;
  createdAt: Date;
  updatedAt: Date;
};

interface IUserProfile {}

export class UserProfile implements TUserProfile, IUserProfile {
  id: string;
  userID: string;
  name: string;
  imageUrl: string;
  createdAt: Date;
  updatedAt: Date;

  constructor(
    id: string = "",
    userID: string = "",
    name: string = "",
    imageUrl: string = "",
    createdAt: Date = new Date(),
    updatedAt: Date = new Date()
  ) {
    this.id = id;
    this.userID = userID;
    this.name = name;
    this.imageUrl = imageUrl;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }
}
