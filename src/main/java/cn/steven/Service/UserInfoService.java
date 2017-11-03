package cn.steven.Service;


import cn.steven.Model.User;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Service;

import java.util.List;


/**
 * Created by IntelliJ IDEA.
 * User: StevenJack
 * Date: ${DATA}
 * Time: 23:30
 * To change this template use File | Settings | File Templates.
 */
@Service
public class UserInfoService extends BaseService<User>{

    @Override
    public void deleteAll(@NotNull List<User> modelList) {
        modelList.forEach(this::delete);
    }
}
