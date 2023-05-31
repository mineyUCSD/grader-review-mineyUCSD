import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;
import java.util.*;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

class IsA implements StringChecker{
	public boolean checkString(String s) { return s.equals("a"); }
}


public class TestListExamples {

  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }
  @Test(timeout = 500)
  public void testSubtleArrays() {
    List<String> s1 = Arrays.asList("a", "b", "a");
    List<String> s2 = Arrays.asList("a", "b");
    List<String> result1 = ListExamples.filter(s1, new IsA());
    List<String> result2 = ListExamples.filter(s2, new IsA());
    List<String> expected1 = Arrays.asList("a","a");
    List<String> expected2 = Arrays.asList("a");
    assertEquals(expected1, result1);
    assertEquals(expected2, result2); 
  }

  @Test(timeout = 500)
  public void testSubtleSize() {
    List<String> s1 = Arrays.asList("a", "b", "a");
    List<String> s2 = Arrays.asList("a", "b");
    List<String> result1 = ListExamples.filter(s1, new IsA());
    List<String> result2 = ListExamples.filter(s2, new IsA());
    List<String> expected1 = Arrays.asList("a","a");
    List<String> expected2 = Arrays.asList("a");
    assertEquals(expected1.size(), result1.size());
    assertEquals(expected2.size(), result2.size());
  }



  @Test(timeout = 500)
  public void testSubtleComparison() {
    List<String> s1 = Arrays.asList("a", "b", "a");
    List<String> s2 = Arrays.asList("a", "b");
    List<String> result1 = ListExamples.filter(s1, new IsA());
    List<String> result2 = ListExamples.filter(s2, new IsA());
    List<String> expected1 = Arrays.asList("a","a");
    List<String> expected2 = Arrays.asList("a");
    assertEquals(true, result1==result2);
  }



  @Test(timeout = 500)
  public void testSubtleEmpty() {
    List<String> s1 = Arrays.asList("a", "b", "a");
    List<String> s2 = new ArrayList<String>();
    List<String> result1 = ListExamples.filter(s1, new IsA());
    List<String> result2 = ListExamples.filter(s2, new IsA());
    List<String> expected1 = Arrays.asList("a","a");
    List<String> expected2 = new ArrayList<String>();
    assertEquals(expected1.size(), result1.size());
    assertEquals(expected2.size(), result2.size());
    assertEquals(false, result1==result2);
  }




 @Test(timeout = 500)
  public void testMergeLeftEnd() {
    List<String> left = Arrays.asList("a", "b", "z");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "d", "z");
    assertEquals(expected, merged);
  }

  @Test(timeout = 500)
  public void testFilterSingle() {
    List<String> input = Arrays.asList("Moon", "MOO", "moo");
    List<String> expect = Arrays.asList("Moon");
    List<String> filtered = ListExamples.filter(input, new IsMoon());
    assertEquals(expect, filtered);
  }

  @Test(timeout = 500)
  public void testFilterMulti() {
    List<String> input = Arrays.asList("Moon", "MOO", "moon", "MOON");
    List<String> expect = Arrays.asList("Moon", "moon", "MOON");
    List<String> filtered = ListExamples.filter(input, new IsMoon());
    assertEquals(expect, filtered);

  }
}
