//
//  main.m
//  Grade Book
//
//  Created by Atara Weinreb on 10/2/19.
//  Copyright © 2019 Atara Weinreb. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Student_Info.h"

NSMutableDictionary *myDictionary;

void removeAllStudents() {
    if ([myDictionary count] == 0)
        return;
    [myDictionary removeAllObjects];
}

void removeStudent(NSString *name) {
    if (![myDictionary objectForKey:name]) {
        return;
    }
    [myDictionary removeObjectForKey:name];
}

BOOL studentAverage(NSString *name) {
    if (![myDictionary objectForKey:name])
        return false;
    
    Student_Info *student = [myDictionary objectForKey:name];
    
    float midterm = [student Midterm];
    float final = [student Final];
    int homework1 = [student Homework1];
    int homework2 = [student Homework2];
    int homework3 = [student Homework3];
    int homework = (homework1 + homework2 + homework3) * 10 /3; //homework is graded out of 10
    
    if (midterm < 0 || final < 0 || homework1 < 0 || homework2 < 0 || homework3 < 0)
        return false;
    float avg = (midterm * .30) + (final * .40) + (homework * .30);
    NSLog(@"Student average: %.1f", avg);
    return true;
}

void printObject(Student_Info *student) {
    NSLog(@"\n****************************************\n\n\n\tName: %@\n\tAddress: %@\n\tMidterm: %.1f\n\tFinal: %.1f\n\tHomework #1: %.d\n\tHomework #2: %d\n\tHomework #3: %d\n\n\n****************************************", (NSString *)student.Name, (NSString *)student.Address, student.Midterm, student.Final, student.Homework1, student.Homework2, student.Homework3);
}

void enumerateAllStudents() {
    for(NSString *key in myDictionary) {
        Student_Info *temp = [myDictionary objectForKey:key];
        NSLog(key);
        printObject(temp);
    }
}

BOOL addStudent(NSString *name, NSString *address) {
    Student_Info *student = [[Student_Info alloc] init];
    [student setName:name];
    [student setAddress:address];
    [student setMidterm:-999];
    [student setFinal:-999];
    [student setHomework1:-999];
    [student setHomework2:-999];
    [student setHomework3:-999];
    if (!myDictionary) {
        myDictionary = [[NSMutableDictionary alloc] init];
        [myDictionary setObject:student forKey:name];
        return true;
    }
    else if ([myDictionary objectForKey:name]){ //duplicate
        return false;
    }
    else {
        [myDictionary setObject:student forKey:name];
        return true;
    }
}

BOOL addTest(NSString *name, float score, NSString *test) {
    if ([myDictionary objectForKey:name]) {
        Student_Info *student = [myDictionary objectForKey:name];
        if ([test isEqualToString:@"midterm"])
            [student setMidterm:score];
        else if ([test isEqualToString:@"final"])
            [student setFinal:score];
        else
            return false;
        return true;
    }
    return false;
}

BOOL addHomework(NSString *name, int assignment, int score) {
    if (assignment < 1 || assignment > 3 || ![myDictionary objectForKey:name])
        return false;
    Student_Info *student = [myDictionary valueForKey:name];
    if (assignment == 1)
        [student setHomework1:score];
    else if (assignment == 2)
        [student setHomework2:score];
    else if (assignment == 3)
        [student setHomework3:score];
    return true;
}


int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        
        //Student #1
        addStudent(@"Bob", @"100 Central Ave");
        addTest(@"Bob", 85, @"midterm");
        addTest(@"Bob", 95, @"final");
        addHomework(@"Bob", 1, 7);
        addHomework(@"Bob", 2, 6);
        addHomework(@"Bob", 3, 10);
        
        //Student #2
        addStudent(@"Molly", @"80 Charles St");
        addTest(@"Molly", 70, @"midterm");
        addTest(@"Molly", 65, @"final");
        addHomework(@"Molly", 1, 7);
        addHomework(@"Molly", 2, 4);
        addHomework(@"Molly", 3, 9);
        
        //Student #3
        addStudent(@"Carol", @"12 Virginia St");
        addTest(@"Carol", 100, @"midterm");
        addTest(@"Carol", 98.5, @"final");
        addHomework(@"Carol", 1, 9);
        addHomework(@"Carol", 2, 10);
        addHomework(@"Carol", 3, 10);
        
        //Student #4
        addStudent(@"David", @"44 Crestwood Rd");
        addTest(@"David", 77, @"midterm");
        addTest(@"David", 82.5, @"final");
        addHomework(@"David", 1, 10);
        addHomework(@"David", 2, 3);
        addHomework(@"David", 3, 6);
        
        //Student #5
        addStudent(@"Sarah", @"111 Woodmere Place");
        addTest(@"Sarah", 45, @"midterm");
        addTest(@"Sarah", 55, @"final");
        addHomework(@"Sarah", 1, 6);
        addHomework(@"Sarah", 2, 2);
        addHomework(@"Sarah", 3, 4);
        
        enumerateAllStudents();
        removeStudent(@"Carol");
        enumerateAllStudents();
        removeAllStudents();
        
        //Student #6
        addStudent(@"Claire", @"8 Willow Rd");
        addTest(@"Claire", 100, @"midterm");
        addTest(@"Claire", 100, @"final");
        addHomework(@"Claire", 1, 10);
        addHomework(@"Claire", 2, 10);
        addHomework(@"Claire", 3, 10);
        
        //Student #7
        addStudent(@"Emily", @"33 Northfield Rd");
        addTest(@"Emily", 90, @"midterm");
        addTest(@"Emily", 75, @"final");
        addHomework(@"Emily", 1, 6);
        addHomework(@"Emily", 2, 10);
        addHomework(@"Emily", 3, 10);
        
        enumerateAllStudents();
    }
    return 0;
}

