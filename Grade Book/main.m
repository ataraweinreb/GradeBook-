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

void printObject(Student_Info *student) {
    NSLog(@"Name: %@\n\tAddress: %@\n\tMidterm: %.1f\n\tFinal: %.1f\n\tHomework #1: %.d\n\tHomework #2: %d\n\tHomework #3: %d\n\t", (NSString *)student.Name, (NSString *)student.Address, student.Midterm, student.Final, student.Homework1, student.Homework2, student.Homework3);
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


int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        NSLog(@"Hello, World!");
        addStudent(@"harry", @"310 eastwood rd");
        addStudent(@"harry", @"310 eastwood rd");
        addStudent(@"hkhsadh", @"310 eastwood rd");
        addTest(@"harry", 75, @"midterm");
        addTest(@"harry", 87, @"final");
        addHomework(@"harry", 1, 10);
        addHomework(@"harry", 2, 10);
        addHomework(@"harry", 3, 10);
        studentAverage(@"harry");
        for(NSString *key in myDictionary) {
            Student_Info *temp = [myDictionary objectForKey:key];
            printObject(temp);
        }
    }
    return 0;
}

