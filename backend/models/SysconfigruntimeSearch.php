<?php

namespace backend\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use backend\models\Sysconfigruntime;

/**
 * SysconfigruntimeSearch represents the model behind the search form about `backend\models\Sysconfigruntime`.
 */
class SysconfigruntimeSearch extends Sysconfigruntime
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['run_id', 'run_rid'], 'integer'],
            [['run_gid', 's_runtime', 'e_runtime'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = Sysconfigruntime::find();

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        $query->andFilterWhere([
            'run_id' => $this->run_id,
            'run_rid' => $this->run_rid,
            's_runtime' => $this->s_runtime,
            'e_runtime' => $this->e_runtime,
        ]);

        $query->andFilterWhere(['like', 'run_gid', $this->run_gid])
            ;

        return $dataProvider;
    }
}
