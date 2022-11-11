package ${packagePrefix}.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;



/**
 * 
 * ### auto generate code.
 *
 * @param <T> The class type of target bean
 * @param <PK> The type of the identifier in Hibernate mapping
 */
public interface GenericDao <T, PK extends Serializable> {

    /**
     * Persist the newInstance object into database.
     * 
     * @param newInstance
     * @return
     */
    PK create(T newInstance);

    /**
     * Retrieve an object that was previously persisted to the database using
     *   the indicated id as primary key.
     *   
     * @param id
     * @return
     */
    T read(PK id);

    /**
     * Query the table with specified conditions, i.e. matchers
     * 
     * @param matchers
     * @throws DataSourceException
     */
    List<T> query(Map<String, Object> matchers);
    
    /**
     * Save changes made to a persistent object.
     * 
     * @param transientObject
     */
    void update(T transientObject);

    /**
     * Save specific changes made to a persistent object by its id.
     * 
     * @param modifiers
     * @param id
     * @throws DataSourceException
     */
    void update(Map<String, Object> modifiers, PK id);
    
    /**
     * Save specific changes made to the matched persistent objects.
     * 
     * @param modifiers The column and value to be updated into db
     * @param matchers The column and value to find the match, i.e. in WHERE clause
     * @throws DataSourceException
     */
    int update(Map<String, Object> modifiers, Map<String, Object> matchers);
    
    
    /**
     * Save specific changes made to the matched persistent objects.
     * 
     * @param modifiers The column and value to be updated into db
     * @param matchers The column and value to find the match, i.e. in WHERE clause
     * @throws DataSourceException
     */
    void updateFields(String updateFields, Map<String, Object> matchers);
    
    /**
     * Remove an object from persistent storage in the database.
     * 
     * @param persistentObject
     */
    void delete(T persistentObject);

    /**
     * Remove an object by it's id.
     * 
     * @param id
     */
    void delete(PK id);
    
    /**
     * save or update object
     * @param transientObject
     */
    void saveOrUpdate(T transientObject);
    
    /**
     * merge the different object
     * @param transientObject
     */
    void merge(T transientObject);
    
    /**
     * get ListBy Name Query
     * @param queryName
     * @param condition
     * @return
     */
    List<T> nameQuery(String queryName , Map<String, Object> condition);
}
