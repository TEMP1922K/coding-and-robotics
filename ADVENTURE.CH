/*
 * File Name:  ADVENTURE.CH
 * Choose Your Own Adventure
 * 
 * https://docs.google.com/document/d/1XknLWw2nL5BYYerpx9z1Vhwq1bUDdT19Sq5kHf6bRnc/edit
 * 
 * 12/13/2019
 */

#include <chplot.h>
#include <math.h>

const int NAME_SETTING_ENABLED = 1; 
const int PLOTS_ENABLED = 0;  // Extra, and unfinished

string_t introAnswer; 
int namesHaveBeenSet; 

// 2 RandInt
int r1 = randint(100, 3000); // Low Valuable Value
int r2 = randint(3000, 9000); // High Valuable Value

// 2 characters
string_t name1 = "NAME_1";  // Can be set in intro
string_t name2 = "NAME_2";  // Can be set in intro, used in end 8

/*
 * 6 functions (and more)
 */
/*
 * Face (or not)
 */

void plotBadEnding() {
    // Unfinished frown that is not smooth curving and has no eyes
    if (PLOTS_ENABLED) {
        // Ch User Guide page 417
        int numpoints = 16; 
        array double x[numpoints], y[numpoints]; 
        class CPlot plot; 
        lindata(-10, 10, x); 
        y = -fabs(x); 
        plot.data2D(x, y); 
        plot.plotting(); 
    }
}

void plotGoodEnding() {
    // Unfinished smile that is not smooth curving and has no eyes
    if (PLOTS_ENABLED) {
        // Ch User Guide page 417
        int numpoints = 16; 
        array double x[numpoints], y[numpoints]; 
        class CPlot plot; 
        lindata(-10, 10, x); 
        y = fabs(x); 
        plot.data2D(x, y); 
        plot.plotting(); 
    }
}

// Answer Loop
string_t answerLoop(string_t prompt) {
    string_t returnValue; 
    string_t dummy = "Dummy, \n"; 
    int isDummyNext = 0; 
    // Answer loop takes strings because of dummies who can't type numbers.
    do {
        if (isDummyNext) {
            printf(dummy);  // Knock some sense into the dummy
        }
        printf(prompt); 
        if (isDummyNext) {
            printf("TYPE THE NUMBER\n");  // Knock some sense into the dummy
        }
        scanf("%s", &returnValue); 
        isDummyNext = 1; 
    } while(!((returnValue == "1") || (returnValue == "2") || (returnValue == "3")));  // while(returnValue < 1 || introAnswer > 3); 
    return returnValue; 
}

/*
 * Intro
 */
// Introduction
void intro() {
    printf("Welcome to the story.\n"); 
    printf("This is the most random story ever.\n"); 
    printf("A character starts somewhere, and can go to one of three places.\n"); 
    printf("Make the right choices or this character dies.\n"); 
    printf("Try to find good endings.\n"); 
    if (NAME_SETTING_ENABLED && !namesHaveBeenSet) {
        printf("What is the name of the character?\n"); 
        scanf("%s", &name1); 
        printf("Who is the character's friend?\n"); 
        scanf("%s", &name2); 
        namesHaveBeenSet = 1; 
    }
    printf("1 | Go to Castle\n"); 
    printf("2 | Go to Forest\n"); 
    printf("3 | Go to Town\n"); 
    // Answer loop takes strings because of dummies who can't type numbers.
    do {
        printf("Do you choose 1, 2, or 3?\n                                                             -1 to quit now, 0 to cheat\n"); 
        scanf("%s", &introAnswer); 
    } while(!((introAnswer == "-1") || (introAnswer == "0") || (introAnswer == "1") || (introAnswer == "2") || (introAnswer == "3")));  // while((introAnswer < -1) || (introAnswer > 3)); 
    if (introAnswer == "-1") {
        exit(1); 
    }
}

/*
 * Middle
 */
// Option 1
void option1() {
    printf("%s enters the castle\n", name1); 
    printf("It seems like an average castle.\n"); 
    printf("But this castle is full of traps.\n"); 
    printf("If a room doesn't have a trap it may have gold.\n"); 
    printf("Pick a room.\n"); 
    // PROMPT NEXT
    printf("OPTIONS\n"); 
    printf("1 | Enter the first room\n"); 
    printf("2 | Enter the second room\n"); 
    printf("3 | Enter the third room\n"); 
}

// Option 2
void option2() {
    printf("%s enters the forest\n", name1); 
    printf("The forest has lots of trees.\n"); 
    printf("This forest also has many places to explore.\n"); 
    printf("Some paths may lead to death.\n"); 
    printf("Pick the best choice.\n"); 
    // PROMPT NEXT
    printf("OPTIONS\n"); 
    printf("1 | Enter valley\n"); 
    printf("2 | Enter cave\n"); 
    printf("3 | Climb mountain\n"); 
}

// Option 3
void option3() {
    printf("%s enters the town\n", name1); 
    printf("There aren't many people here.\n"); 
    printf("There is fog here.\n"); 
    printf("Seems like this town has been abandoned.\n"); 
    printf("Maybe something good can be found in the alley, or maybe friends can be found here.\n"); 
    // PROMPT NEXT
    printf("OPTIONS\n"); 
    printf("1 | Go in an alley\n"); 
    printf("2 | Look for a friend\n"); 
    printf("3 | Jump in a hole\n"); 
}

/*
 * End
 */
// End 1
void end1() {
    printf("%s enters the first room.\n", name1); 
    printf("%s looks around.\n", name1); 
    printf("%s walks toward some gold.\n", name1); 
    printf("It was a trap.\n"); 
    printf("Burning boulder falls on %s. Death by fire.\n", name1); 
    plotBadEnding(); 
}

// End 2
void end2() {
    printf("%s enters the second room\n", name1); 
    printf("%s looks around.\n", name1); 
    printf("%s sees gold.\n", name1); 
    printf("%s approaches the gold. But it's a trap...\n", name1); 
    printf("That room collapsed on %s. %s died.\n", name1, name1); 
    plotBadEnding(); 
}

// End 3
void end3() {
    printf("%s enters the third room.\n", name1); 
    printf("%s looks around.\n", name1); 
    printf("%s found gold here.\n", name1); 
    printf("It's worth $%d.\n", r2); 
    printf("%s sells the gold and goes home.\n", name1); 
    plotGoodEnding(); 
}

// End 4
void end4() {
    printf("%s walks into the valley.\n", name1); 
    printf("%s looks around.\n", name1); 
    printf("Fire starts, and spreads quickly.\n"); 
    printf("%s is surrounded by fire.\n", name1); 
    printf("%s dies.\n", name1); 
    plotBadEnding(); 
}

// End 5
void end5() {
    printf("%s enters the cave.\n", name1); 
    printf("%s sees water.\n", name1); 
    printf("%s continues to look around.\n", name1); 
    printf("%s encounters a bear.\n", name1); 
    printf("%s gets eaten by the bear.\n", name1); 
    plotBadEnding(); 
}

// End 6
void end6() {
    printf("%s goes to climb a short mountain.\n", name1); 
    printf("%s finds diamonds along the way.\n", name1); 
    printf("%s makes it to the top of the mountain.\n", name1); 
    printf("%s collected $%d worth of diamonds.\n", name1, r2); 
    printf("%s climbs back down and goes home.\n", name1); 
    plotGoodEnding(); 
}

// End 7
void end7() {
    printf("%s walks into the alley.\n", name1); 
    printf("%s finds boxes.\n", name1); 
    printf("%s opens the boxes.\n", name1); 
    printf("%s finds $%d and keeps it.\n", name1, r1); 
    printf("%s goes home.\n", name1); 
    plotGoodEnding(); 
}

// End 8
void end8() {
    printf("%s tries to find a friend.\n", name1); 
    printf("%s spends 10 minutes looking for a friend.\n", name1); 
    printf("%s finds %s.\n", name1, name2); 
    printf("%s decides to come over to %s's house.\n", name2, name1); 
    printf("They both go to %s's house and they DON'T die.\n", name1); 
    plotGoodEnding(); 
}

// End 9
void end9() {
    printf("%s jumps in the hole.\n", name1); 
    printf("%s sees only darkness.\n", name1); 
    printf("%s was expecting to find something in here...\n", name1); 
    printf("%s hits a bottom.\n", name1); 
    printf("%s dies.\n", name1); 
    plotBadEnding(); 
}

// Road Map
void cheatV1() {
    printf("CHEAT\n"); 
    printf("Option 1 Enter castle\n"); 
    printf("      End 1 Death by fire boulder trap\n"); 
    printf("      End 2 Death by collapse trap\n"); 
    printf("      End 3 Found gold pile\n"); 
    printf("Option 2 Enter forest\n"); 
    printf("      End 4 Death by forest fire\n"); 
    printf("      End 5 Death by bear\n"); 
    printf("      End 6 Find diamonds\n"); 
    printf("Option 3 Enter town\n"); 
    printf("      End 7 Find money\n"); 
    printf("      End 8 Find friend\n"); 
    printf("      End 9 Fall and die\n"); 
    printf("____________________________________________________\n"); 
}
void cheatV2() {
    printf("================== ROAD MAP! ==================\n"); 
    printf("                  /    |    \\                  \n"); 
    printf("                 /     |     \\                 \n"); 
    printf("                /      |      \\                \n"); 
    printf("               /       |       \\               \n"); 
    printf("           CASTLE    FOREST    TOWN            \n"); 
    printf("             /         |         \\             \n"); 
    printf("            /          |          \\            \n"); 
    printf("           /           |           \\           \n"); 
    printf("          /            |            \\          \n"); 
    printf("  ===========     ===========     ===========  \n"); 
    printf("  |    |    |     |    |    |     |    |    |  \n"); 
    printf(" DIE  DIE  WIN   DIE  DIE  WIN   WIN  WIN  DIE \n"); 
    printf("===============================================\n"); 
}
/*
 * STARTER
 * Runs through
 */
int main() { // *********************************************************************************
    /*
    if (!PLOTS_ENABLED) {
        printf("! PLOTS DISABLED\n"); 
        printf("\n\n\n\n\n\n\n\n\n"); 
    }
     */
    intro(); 
    // Answer loop takes strings because of dummies who can't type numbers.
    // Road Map
    if (introAnswer == "0") {
        cheatV2(); 
        intro(); 
    }
    // Option 1
    if (introAnswer == "1") {
        option1(); 
        // Answer loop takes strings because of dummies who can't type numbers.
        string_t next = answerLoop(name1 + " is in the castle. What should " + name1 + " do next?\n"); 
        if (next == "1") {
            // End 1
            end1(); 
        }
        if (next == "2") {
            // End 2
            end2(); 
        }
        if (next == "3") {
            // End 3
            end3(); 
        }
    }
    // Option 2
    if (introAnswer == "2") {
        option2(); 
        // Answer loop takes strings because of dummies who can't type numbers.
        string_t next = answerLoop(name1 + " is in the forest. What should " + name1 + " do next?\n"); 
        if (next == "1") {
            // End 4
            end4(); 
        }
        if (next == "2") {
            // End 5
            end5(); 
        }
        if (next == "3") {
            // End 6
            end6(); 
        }
    }
    // Option 3
    if (introAnswer == "3") {
        option3(); 
        // Answer loop takes strings because of dummies who can't type numbers.
        string_t next = answerLoop(name1 + " is in the town. What should " + name1 + " do next?\n"); 
        if (next == "1") {
            // End 7
            end7(); 
        }
        if (next == "2") {
            // End 8
            end8(); 
        }
        if (next == "3") {
            // End 9
            end9(); 
        }
    }
}
