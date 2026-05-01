export interface CreateProfileInput {
  userID: string;
}

export interface UpdateBioInput {
  userID: string;
  bio: string;
}

export interface UpdateAvatarInput {
  userID: string;
  avatarUrl: string;
}
