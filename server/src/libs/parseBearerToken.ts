export const parseBearerToken = (token: string | undefined): string | Error => {
  if (!token) {
    return new Error("No token provided");
  }

  // use regex to parse the token
  const regex = /Bearer (.+)/;
  const matches = token.match(regex);
  if (!matches) {
    return new Error("Invalid token");
  }
  return matches[1];
};
