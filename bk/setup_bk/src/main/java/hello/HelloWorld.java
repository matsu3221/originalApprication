package hello;

import org.joda.time.LocalTime;

public class HelloWorld {

  public static void main(String[] args) {
  LocalTime currentTime = new LocalTime();
  System.out.println("現在の時間は" + currentTime);
    Greeter greeter = new Greeter();
    System.out.println(greeter.sayHello());
  }
}