import java.util.LinkedList;

public class PikaStack<T> {
  // A stack in which we can peek at any element
  
  public List<T> data;
  
  public PikaStack(){
    data = new LinkedList<T>();
  }
  
  public void push(T t){
    data.add(0, t); 
  }
  
  public T pop(){
    return data.remove(0); 
  }
  
  public T peek(int index){
    return data.get(index);
  }
}
