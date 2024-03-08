package com.caunus.sampleapp;

public class Addition {

    public static void main(String[] args) {
        
        for (int i = 0; i < 1; i++) {
            int sum = 0;
            for (int j = 1; j < 11; j++) {
                sum += j; 
            }
            System.out.println("java: sigma(10) = " + sum);
        }

        // wait 1s
        try {
            Thread.sleep(1000);
		} catch (InterruptedException e) {
		}
    }
}