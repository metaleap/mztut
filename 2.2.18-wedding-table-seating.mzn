include "globals.mzn";

enum Guests = { bride, groom, bestman, bridesmaid, bob, carol, ted, alice, ron, rona, eddie, clara};
set of int: Seats = 1..12;
set of int: Dislikes = 1..5;
set of Guests: Males = {groom, bestman, bob, ted, ron, eddie};
set of Guests: Females = {bride, bridesmaid, carol, alice, rona, clara}; 

% these 2 arrs would probably 1-arr-of-pairs if tuples had been already introduced in this chapter...
array[Dislikes] of Guests: dislikes1 = [groom, carol, eddie, bride, ted];
array[Dislikes] of Guests: dislikes2 = [clara, bestman, ted, alice, ron];

array[Guests] of var Seats: guestSeats;
array[Dislikes] of var Seats: dislikes1Seats;
array[Dislikes] of var Seats: dislikes2Seats;
array[Dislikes] of var 0..1: dislikesSameSideSeats;
array[Dislikes] of var Seats: dislikeCosts;

constraint alldifferent(guestSeats);

% males at odd-numbered places and females at even-numbered ones
constraint forall(guest in Males) (1 == (guestSeats[guest] mod 2));
constraint forall(guest in Females) (0 == (guestSeats[guest] mod 2));

% eddie has a phobia about sitting at any end of table
constraint not (guestSeats[eddie] in {1,6,7,12}); 

% bride and groom next to each other
constraint (abs(guestSeats[bride] - guestSeats[groom]) <= 1)  /\  (guestSeats[bride]<=6 <-> guestSeats[groom]<=6);

% deal with interpersonal dislikes
constraint forall(i in Dislikes)
             ((dislikes1Seats[i] == guestSeats[dislikes1[i]]) /\
              (dislikes2Seats[i] == guestSeats[dislikes2[i]]) /\
              (dislikesSameSideSeats[i] == bool2int(dislikes1Seats[i] <= 6 <-> dislikes2Seats[i] <= 6)) /\
              (dislikeCosts[i] == (dislikesSameSideSeats[i] * abs(dislikes1Seats[i] - dislikes2Seats[i]) + (1 - dislikesSameSideSeats[i]) * (abs(13 - dislikes1Seats[i] - dislikes2Seats[i]) + 1))));

solve maximize sum(dislike in Dislikes) (dislikeCosts[dislike]);
