import java.util.Comparator;

public class ComparatorCCW implements Comparator<Point>{
  
  /* Must be an extreme point, e.g., the bottom-right-most, 
  in order to make sense for use in sorting
  (if other points circle around it, 
  you'd have no "least" or "greatest" point). */
  
  Point origin; 
  
  public ComparatorCCW(Point reference){
    origin = reference; 
  }
  
  public int compare(Point a, Point b){
    /* -1: origin is to the left of line ab, i.e., a is clockwise to b
           OR they're colinear and a is closer to origin than b     
       0: a=b
       1: origin is to the right of the line ab, i.e., a is counterclockwise to b
           OR they're colinear and b is closer to origin than a
    */
    
    if (a.equals(b)) { 
      return 0; 
    }
    // Make sure the origin is always the smallest element
    else if (a.equals(origin)) { 
      return -1; 
    } 
    else if (b.equals(origin)) { 
      return 1; 
    }
    else {
      int sideOfLine = origin.sideOfLine(a, b);
      if (sideOfLine == 0){
        double distSquaredA = origin.distanceSquared(a);
        double distSquaredB = origin.distanceSquared(b);
        if (distSquaredA < distSquaredB){
          return -1;  
        }
        else if (distSquaredA > distSquaredB){
          return 1;  
        }
        else {
          return 0;  
        }
      }  
      return sideOfLine; 
    }
  }
  
}
