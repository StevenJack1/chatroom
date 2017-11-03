package cn.steven.Service;


import cn.steven.Model.User;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.List;


@SuppressWarnings("unchecked")
@Service
public class UserService extends BaseService<User>{

    @Deprecated
    @Override
    public void save(@NotNull User user) {
        throw new UnsupportedOperationException("不支持该方法");
    }

    @Deprecated
    @Override
    public void saveAll(@NotNull List<User> userList) {
        throw new UnsupportedOperationException("不支持该方法");
    }

    @Deprecated
    public void updatePassWord(@NotNull User user) {
        throw new UnsupportedOperationException("不支持该方法");
    }

    @Deprecated
    public void updateAllPassWord(@NotNull List<User> userList) {
        throw new UnsupportedOperationException("不支持该方法");
    }

    @Deprecated
    @Override
    public void saveOrUpdate(@NotNull User user) {
        throw new UnsupportedOperationException("不支持该方法");
    }

    @Deprecated
    @Override
    public void saveOrUpdateAll(@NotNull List<User> userList) {
        super.saveOrUpdateAll(userList);
    }


    @Deprecated
    @Override
    public void delete(@NotNull User model) {
        throw new UnsupportedOperationException("不支持该方法");
    }

    @Deprecated
    @Override
    public void deleteAll(@NotNull List<User> modelList) {
        throw new UnsupportedOperationException("不支持该方法");
    }

    @Deprecated
    @Override
    public void deleteById(@NotNull Serializable id) {
        throw new UnsupportedOperationException("不支持该方法");
    }





}
