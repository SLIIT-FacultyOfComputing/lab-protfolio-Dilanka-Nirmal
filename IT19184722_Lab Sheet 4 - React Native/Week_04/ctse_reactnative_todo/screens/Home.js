import {
  View,
  Text,
  FlatList,
  StyleSheet,
  TextInput,
  TouchableOpacity,
  Keyboard,
  Pressable,
} from 'react-native';
import React, {useState, useEffect} from 'react';
import {firebase} from '../config';
import {useNavigation} from '@react-navigation/native';
import Icon from 'react-native-vector-icons/MaterialCommunityIcons';

const Home = () => {
  const [todos, setTodos] = useState([]);
  const todoRef = firebase.firestore().collection('todos');
  const [addData, setAddData] = useState('');
  const navigation = useNavigation();

  // Fetch or read data from firestore
  useEffect(() => {
    todoRef.orderBy('createdAt', 'desc').onSnapshot(querySnapshot => {
      const todos = [];
      querySnapshot.forEach(doc => {
        const {heading} = doc.data();
        todos.push({
          id: doc.id,
          heading,
        });
        setTodos(todos);
      });
    });
  }, []);

  // Delete data from firestore
  const deleteTodo = todos => {
    todoRef
      .doc(todos.id)
      .delete()
      .then(() => {
        alert('Todo deleted successfully');
      })
      .catch(error => {
        alert(error);
      });
  };

  // Add data to firestore
  const addTodo = () => {
    if (addData && addData.length > 0) {
      const timestamp = firebase.firestore.FieldValue.serverTimestamp();
      const data = {
        heading: addData,
        createdAt: timestamp,
      };
      todoRef
        .add(data)
        .then(() => {
          setAddData('');
          Keyboard.dismiss();
        })
        .catch(error => {
          alert(error);
        });
    }
  };

  return (
    <View style={{flex: 1}}>
      <View style={styles.formContainer}>
        <TextInput
          style={styles.input}
          placeholder="Add new Todo"
          placeholderTextColor="#aaaaaa"
          onChangeText={heading => setAddData(heading)}
          value={addData}
          underlineColorAndroid="transparent"
          autoCapitalize="none"
        />
        <TouchableOpacity style={styles.button} onPress={() => addTodo()}>
          <Text style={styles.buttonText}>Add</Text>
        </TouchableOpacity>
      </View>
      <FlatList
        data={todos}
        numColumns={1}
        renderItem={({item}) => (
          <View>
            <Pressable
              style={styles.container}
              onPress={() => navigation.navigate('Detail', {item})}>
              <Icon
                name="delete"
                color="red"
                onPress={() => deleteTodo(item)}
                style={styles.todoIcon}
              />
              <View style={styles.innerContainer}>
                <Text style={styles.itemHeading}>
                  {item.heading[0].toUpperCase() + item.heading.slice(1)}
                </Text>
              </View>
            </Pressable>
          </View>
        )}
      />
    </View>
  );
};

export default Home;

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#e5e5e5',
    padding: 15,
    borderRadius: 15,
    margin: 5,
    marginHorizontal: 10,
    flexDirection: 'row',
    alignItems: 'center',
  },
  innerContainer: {
    alignItems: 'center',
    flexDirection: 'row',
    marginLeft: 45,
  },
  itemHeading: {
    fontSize: 18,
    fontWeight: 'bold',
    marginRight: 22,
  },
  formContainer: {
    flexDirection: 'row',
    height: 80,
    marginLeft: 10,
    marginRight: 10,
    marginTop: 100,
  },
  input: {
    height: 48,
    borderRadius: 5,
    overflow: 'hidden',
    backgroundColor: 'white',
    paddingLeft: 16,
    flex: 1,
    marginRight: 5,
  },
  button: {
    height: 47,
    borderRadius: 5,
    backgroundColor: '#788eec',
    width: 80,
    alignItems: 'center',
    justifyContent: 'center',
  },
  buttonText: {
    color: 'white',
    fontSize: 20,
  },
  todoIcon: {
    marginTop: 5,
    fontSize: 20,
    marginLeft: 14,
  },
});
